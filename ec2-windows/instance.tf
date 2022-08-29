data "aws_key_pair" "softserve" {
  key_name = var.PUBLIC_KEY
}

resource "aws_instance" "windows" {
  instance_type = "t2.medium"
  key_name      = data.aws_key_pair.softserve.key_name
  ami           = data.aws_ami.windows-ami.image_id # ami-08b3f7210f8afa7e3
  user_data     = <<EOF
<powershell>
net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
net localgroup administrators ${var.INSTANCE_USERNAME} /add

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF

  provisioner "file" {
    source      = "script.ps1"
    destination = "C:/script.ps1"
  }

  connection {
    host     = coalesce(self.public_ip, self.private_ip)
    type     = "winrm"
    timeout  = "10m"
    user     = var.INSTANCE_USERNAME
    password = var.INSTANCE_PASSWORD
  }
}

# SG type RDP TCP 3389 source:31.0.74.132/32 description: