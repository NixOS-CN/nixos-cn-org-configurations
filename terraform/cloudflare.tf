provider "cloudflare" {
}

variable "cloudflare_account_id" {
  type = string
}

resource "cloudflare_zone" "nixos_cn_org" {
  account_id = var.cloudflare_account_id
  zone       = "nixos-cn.org"
}

# ttl = 1 for automatic

# apex

resource "cloudflare_record" "apex" {
  name    = "nixos-cn.org"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "nixos-cn.github.io"
  zone_id = cloudflare_zone.nixos_cn_org.id
}

# www

resource "cloudflare_record" "www" {
  name    = "www"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "nixos-cn.github.io"
  zone_id = cloudflare_zone.nixos_cn_org.id
}
