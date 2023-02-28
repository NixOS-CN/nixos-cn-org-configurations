terraform {
  cloud {
    organization = "nixos-cn"

    workspaces {
      name = "nixos-cn-org-configurations"
    }
  }
}
