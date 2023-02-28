terraform {
  cloud {
    organization = "nixos-cn"

    workspaces {
      name = "infrastructure"
    }
  }
}
