provider "vscale" {
  token = "${var.do_token}"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


# Create a new scalet
resource "vscale_scalet" "test" {
  count     = "${length(var.devs)}"
  name      = "${var.devs[count.index]}"
  ssh_keys  = ["${vscale_ssh_key.Sergey_Babanin1.id}","${vscale_ssh_key.REBRAIN_SSH_PUB_KEY.id}"]
  make_from = "${var.vscale_centos_7}"
  location  = "${var.vscale_msk}"
  rplan     = "${var.vscale_rplan["s"]}"

provisioner "remote-exec" {
   inline = [
     "/bin/echo -e  root:'${random_string.password[count.index].result}' | chpasswd",
     "hostnamectl set-hostname ${var.devs[count.index]}",
     "systemctl stop firewalld"
   ]
}

connection {
  type     = "ssh"
  user     = "root"
  private_key = "${file("~/.ssh/id_rsa")}"
  host = self.public_address
 }

}   

resource "random_string" "password" {
  length  = 16
  special = true
  count   = 1
}


# Create a new SSH key
resource "vscale_ssh_key" "Sergey_Babanin1" {
  name = "Sergey_Babanin1"
  key  = "${file("~/.ssh/id_rsa.pub")}"
}

# Added  SSH key Rebrain
resource "vscale_ssh_key" "REBRAIN_SSH_PUB_KEY" {
  name = "REBRAIN_SSH_PUB_KEY"
  key  = "${file("~/.ssh/REBRAIN_SSH_PUB_KEY.pub")}"
}

data "aws_route53_zone" "zone_Sergey_Babanin1"{
  name = "devops.rebrain.srwx.net"
}

resource "aws_route53_record" "dns_Sergey_Babanin1" {
  name    = "dns_Sergey_Babanin1.${data.aws_route53_zone.zone_Sergey_Babanin1.name}"
  zone_id = "${data.aws_route53_zone.zone_Sergey_Babanin1.zone_id}"
  type    = "A"
  ttl     = "300"
  count   = 2
  records = ["${element(vscale_scalet.test.*.public_address,count.index)}"]
  allow_overwrite = true
}


