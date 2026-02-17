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
  proxied = true
  ttl     = 1
  type    = "A"
  content   = "8.8.8.8" # just a placeholder, will be redirected to nix.org.cn
  zone_id = cloudflare_zone.nixos_cn_org.id
}

resource "cloudflare_ruleset" "meetup" {
  zone_id     = cloudflare_zone.nixos_cn_org.id
  name        = "redirect meetup to nix.org.cn"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    ref         = "redirect_old_url"
    expression  = "(http.host eq \"meetup.nixos-cn.org\")"
    action      = "redirect"
    action_parameters {
      from_value {
        status_code = 302
        target_url {
          value = "https://nix.org.cn"
        }
        preserve_query_string = false
      }
    }
  }
}
