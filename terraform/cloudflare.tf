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

# reimport all resources

import {
  to = cloudflare_zone.nixos_cn_org
  id = "75b1fd9c9c27d1383681f44b596b171c"
}

import {
  to = cloudflare_dns_record.apex
  id = "75b1fd9c9c27d1383681f44b596b171c/1d147a30122f9caa4b29638fb5534f1c"
}

import {
  to = cloudflare_dns_record.www
  id = "75b1fd9c9c27d1383681f44b596b171c/4cd8a9ad716359b6fda7b93c7a373947"
}
