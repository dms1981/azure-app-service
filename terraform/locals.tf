locals {
  github-personal-access-token = jsondecode(file("./values/github-personal-access-token.json"))
  az-service-principal         = jsondecode(file("./values/az-service-principal.json"))
}