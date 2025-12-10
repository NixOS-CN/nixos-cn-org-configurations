provider "cloudflare" {
}

variable "cloudflare_account_id" {
  type = string
}

resource "cloudflare_zone" "nixos_cn_org" {
  name = "nixos-cn.org"
  account = {
    id = var.cloudflare_account_id
  }
}

# ttl = 1 for automatic

# apex

resource "cloudflare_dns_record" "apex" {
  name    = "nixos-cn.org"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  content   = "nixos-cn.github.io"
  zone_id = cloudflare_zone.nixos_cn_org.id
}

# www

resource "cloudflare_dns_record" "www" {
  name    = "www.nixos-cn.org"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  content   = "nixos-cn.github.io"
  zone_id = cloudflare_zone.nixos_cn_org.id
}

# meetup

resource "cloudflare_dns_record" "meetup" {
  name    = "meetup.nixos-cn.org"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  content   = "nixos-cn.github.io"
  zone_id = cloudflare_zone.nixos_cn_org.id
}
