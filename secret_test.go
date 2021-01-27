package main

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestKubernetesDockerSecret(t *testing.T) {
	name := fmt.Sprintf("docker-%s", strings.ToLower(random.UniqueId()))

	opts := &terraform.Options{
		TerraformDir: "./",
		Vars: map[string]interface{}{
			"name":      name,
			"namespace": "default",
			"registries": map[string]interface{}{
				"docker.reg": map[string]interface{}{
					"username": "USER",
					"password": "PASS",
				},
			},
		},
	}
	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)
	require.Equal(t, terraform.Output(t, opts, "name"), name)

	kopts := k8s.NewKubectlOptions("", "", "default")
	secret := k8s.GetSecret(t, kopts, name)

	config, ok := secret.Data[".dockerconfigjson"]
	require.True(t, ok)

	type dockerConfig struct {
		Auths map[string]struct {
			Username string `json:"username"`
			Password string `json:"password"`
			Auth     string `json:"auth"`
		} `json:"auths"`
	}

	var parsed dockerConfig
	require.NoError(t, json.Unmarshal(config, &parsed))

	auth, ok := parsed.Auths["docker.reg"]
	require.True(t, ok)

	require.Equal(t, "USER", auth.Username)
	require.Equal(t, "PASS", auth.Password)

	data, err := base64.StdEncoding.DecodeString(auth.Auth)
	require.NoError(t, err)
	require.Equal(t, "USER:PASS", string(data))
}
