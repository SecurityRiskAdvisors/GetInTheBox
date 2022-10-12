resource "aws_cloudfront_distribution" "c2_redir" {
  count = var.num_distros
  comment = format("[%s/%d] %s", var.project, count.index, var.c2_domain)

  origin {
    domain_name = var.c2_domain
    origin_id   = format("[%s/%d] %s", var.project, count.index, var.c2_domain)

    custom_origin_config {
      http_port = var.c2_port # required, but unused since we restrict to https-only
      https_port = var.c2_port
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = false

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"] # required, but *shouldn't* affect us
    target_origin_id = format("[%s/%d] %s", var.project, count.index, var.c2_domain)

    forwarded_values {
      headers = ["User-Agent", "Authorization"]
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #restriction_type = "whitelist"
      #locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}