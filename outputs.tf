output "Public_ip" {
  value = "${vscale_scalet.test.*.public_address}"
}

output "Name" {
  value = "${vscale_scalet.test.*.name}"
}

output "record_name" {
  value = "${aws_route53_record.dns_Sergey_Babanin1.*.name}"
}

