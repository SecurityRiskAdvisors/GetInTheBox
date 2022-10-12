output "domains" {
  value = [
    for distro in aws_cloudfront_distribution.c2_redir : distro.domain_name
  ]
}