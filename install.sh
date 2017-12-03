#!/bin/bash
host=sslvpn.tsinghua.edu.cn
git clone https://github.com/udomsak/juniper-ncui ~/thu_vpn_linux/
cd ~/thu_vpn_linux/

# generate certification file
bash getx509certificate.sh $host thu.der
(
cat <<EOF
#!/bin/bash
account=\$1
if [ -z "\$account" ]; then
   echo "Please input account(Xuehao) !"
   echo " Usage  :  thuvpn xuehao"
   echo " Example:  thuvpn 2017xxxxxx"
   exit
fi

host=sslvpn.tsinghua.edu.cn
cd ~/thu_vpn_linux/
sudo ./ncsvc -h $host -u \$account -r ldap -f thu.der
EOF
) > thuvpn
chmod +x ./thuvpn

# add environment path
tmp="export PATH=$HOME/thu_vpn_linux:\$PATH"
echo $tmp >> ~/.bashrc
echo $tmp," is added into ~/.bashrc"
