# Get domain zone in Cloudflare

data "restapi_object" "zone" {
  path         = "/client/v4/zones?name=${var.root_domain}"
  search_key   = "status"
  search_value = "active" # make sure we get the active record
  results_key  = "result"
}

# Set records for CS Zone

resource "cloudflare_record" "a_record" {
  count = length(var.ip_addresses)

  zone_id = data.restapi_object.zone.id
  name    = var.subdomain
  value   = var.ip_addresses[count.index]
  type    = "A"
  ttl     = 0
  proxied = false
}