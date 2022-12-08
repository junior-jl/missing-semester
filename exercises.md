# Exercises Lecture 09

### 1. Entropy.
  1. Suppose a password is chosen as a concatenation of four lower-case dictionary words, where each word is selected uniformly at random from a dictionary of size 100,000. An example of such a password is `correcthorsebatterystaple`. How many bits of entropy does this have?
  2. Consider an alternative scheme where a password is chosen as a sequence of 8 random alphanumeric characters (including both lower-case and upper-case letters). An example is `rg8Ql34g`. How many bits of entropy does this have?
  3. Which is the stronger password?
  4. Suppose an attacker can try guessing 10,000 passwords per second. On average, how long will it take to break each of the passwords?

Answer: 

  1. If the words can repeat, there are $10^{20}$ possible combinations. To calculate the bits of entropy:
  
      $$\log_2 10^{20} \approx 66$$
      
  2. There are 26 letters and 10 digits, since the letters can be uppercase or lowercase, there are 62 symbols. So,

      $$\log_2 62^8 \approx 48$$
      
  3. Even though `rg8Q134g` is harder to memorize, `correcthorsebatterstaple` is a stronger password.
  4. `correcthorsebatterstaple`: $\frac{10^{20}}{10^4} = 10^{16} \ s \approx 316 887 646 \ years$
  
     `rg8Q134g`: $\frac{64^8}{10^4} \approx 892 \ years$
     
2. Cryptographic hash functions. Download a Debian image from a mirror (e.g. from this Argentinean mirror). Cross-check the hash (e.g. using the `sha256sum` command) with the hash retrieved from the official Debian site (e.g. this file hosted at debian.org, if you’ve downloaded the linked file from the Argentinean mirror).

Answer:

Downloaded iso: http://debian.xfree.com.ar/debian-cd/current/amd64/iso-cd/debian-11.5.0-amd64-netinst.iso
Hash on debian website: `e307d0e583b4a8f7e5b436f8413d4707dd4242b70aea61eb08591dc0378522f3  debian-11.5.0-amd64-netinst.iso`

```bash
sha256sum debian-11.5.0-amd64-netinst.iso
```

```
e307d0e583b4a8f7e5b436f8413d4707dd4242b70aea61eb08591dc0378522f3  debian-11.5.0-amd64-netinst.iso
```

To check with bash commands (`diff` or `cmp`):

```bash
diff <(sha256sum debian-11.5.0-amd64-netinst.iso) <(echo e307d0e583b4a8f7e5b436f8413d4707dd4242b70aea61eb08591dc0378522f3\ \ debian-11.5.0-amd64-netinst.iso)
```

### 3. Symmetric cryptography. Encrypt a file with AES encryption, using OpenSSL: `openssl aes-256-cbc -salt -in {input filename} -out {output filename}`. Look at the contents using `cat` or `hexdump`. Decrypt it with `openssl aes-256-cbc -d -in {input filename} -out {output filename}` and confirm that the contents match the original using cmp.


Answer: Using the file `last-modified.txt` from previous lessons.

```bash
openssl aes-256-cbc -salt -in last-modified.txt -out last-modified.txt.enc
```

After entering a password, `cat last-modified.txt.enc` returns

```
Salted__<�&?�=�O�V��Q��Zk#���(/�E_'��@c<����L_�
``` 

To decrypt (it will prompt for the password):

```
openssl aes-256-cbc -d -in last-modified.txt.enc -out last-modified.txt.dec
```

Running `cmp last-modified.txt last-modified.txt.dec` shows that the files are equal.

### 4. Asymmetric cryptography.
  1. Set up SSH keys on a computer you have access to (not Athena, because Kerberos interacts weirdly with SSH keys). Make sure your private key is encrypted with a passphrase, so it is protected at rest.
  2. Set up GPG
  3. Send Anish an encrypted email (public key).
  4. Sign a Git commit with `git commit -S` or create a signed Git tag with `git tag -s`. Verify the signature on the commit with `git show --show-signature` or on the tag with `git tag -v`.

Answer: TODO!
