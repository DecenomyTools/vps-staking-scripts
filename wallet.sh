#!/bin/bash
# Wallet deamon must already be running for this script to work.

wallet=./wallet-cli # UPDATE with the wallet client you intend to use and correct path. 

test()
{
$wallet getstakingstatus
}

# Encrypts your wallet without ever saving your pw on vps console history.
encrypt()
{
echo -n "Enter password: "
read -s PASS;
echo
echo -n "Repeat password: "
read -s PASS1;
echo
if [ "$PASS" = "$PASS1" ]; then
$wallet encryptwallet "$PASS"
else
echo "Passwords are not same"; fi

PASS="";
PASS1="";
}

send()
{
ADDRESS=$1
AMOUNT=$2
echo "Sending $AMOUNT to $ADDRESS"
echo -n "Enter password: "
read -s PASS; $wallet walletpassphrase "$PASS" 5; $wallet sendtoaddress $ADDRESS $AMOUNT
PASS=""
}

set_split_threshold()
{
AMOUNT=$1
echo -n "Enter password: "
read -s PASS; $wallet walletpassphrase "$PASS" 5; $wallet setstakesplitthreshold $AMOUNT
PASS=""
}

stake()
{
echo -n "Enter password: "
read -s PASS; $wallet walletpassphrase "$PASS" 0 true
PASS=""
echo "Staking"
}

# Allows you to set the seed for your wallet, which can be derived from a seed phrase using our bip39 tool. 
set_seed()
{
echo -n "Enter password: "
read -s PASS;
echo
echo -n "Enter private key: "
read -s PRIV_KEY;
echo
$wallet walletpassphrase "$PASS" 5; $wallet sethdseed true $PRIV_KEY
PASS=""
}

# You can also import individual addresses for staking
import_key()
{
echo -n "Enter password: "
read -s PASS;
echo
echo -n "Enter private key: "
read -s PRIV_KEY;
echo
$wallet walletpassphrase "$PASS" 5; $wallet importprivkey $PRIV_KEY
PASS=""
}



$1 $2 $3
