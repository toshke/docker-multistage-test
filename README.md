# Docker multi stage build

This works only with docker >= 17.05

## Build container

```
git@github.com:toshke/docker-multistage-test.git
cd docker-multistage-test
docker build -t helloworld:multistage .

$  docker build -t helloworld:multistage .
Sending build context to Docker daemon  36.35kB
Step 1/8 : FROM alpine:latest as build
latest: Pulling from library/alpine
2aecc7e1714b: Already exists
Digest: sha256:0b94d1d1b5eb130dd0253374552445b39470653fb1a1ec2d81490948876e462c
Status: Downloaded newer image for alpine:latest
 ---> a41a7446062d
Step 2/8 : RUN apk add --update alpine-sdk
 ---> Running in c0ede3153e40
fetch http://dl-cdn.alpinelinux.org/alpine/v3.6/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.6/community/x86_64/APKINDEX.tar.gz
(1/59) Installing fakeroot (1.21-r1)
(2/59) Installing sudo (1.8.19_p2-r0)
(3/59) Installing libcap (2.25-r1)
(4/59) Installing pax-utils (1.2.2-r0)
(5/59) Installing libressl2.5-libtls (2.5.4-r0)
(6/59) Installing libressl (2.5.4-r0)
(7/59) Installing libattr (2.4.47-r6)
(8/59) Installing attr (2.4.47-r6)
(9/59) Installing tar (1.29-r1)
(10/59) Installing pkgconf (1.3.7-r0)
(11/59) Installing patch (2.7.5-r1)
(12/59) Installing libgcc (6.3.0-r4)
(13/59) Installing libstdc++ (6.3.0-r4)
(14/59) Installing lzip (1.19-r0)
(15/59) Installing ca-certificates (20161130-r2)
(16/59) Installing libssh2 (1.8.0-r1)
(17/59) Installing libcurl (7.54.0-r0)
(18/59) Installing curl (7.54.0-r0)
(19/59) Installing abuild (3.0.0_rc2-r7)
Executing abuild-3.0.0_rc2-r7.pre-install
(20/59) Installing binutils-libs (2.28-r2)
(21/59) Installing binutils (2.28-r2)
(22/59) Installing gmp (6.1.2-r0)
(23/59) Installing isl (0.17.1-r0)
(24/59) Installing libgomp (6.3.0-r4)
(25/59) Installing libatomic (6.3.0-r4)
(26/59) Installing mpfr3 (3.1.5-r0)
(27/59) Installing mpc1 (1.0.3-r0)
(28/59) Installing gcc (6.3.0-r4)
(29/59) Installing musl-dev (1.1.16-r9)
(30/59) Installing libc-dev (0.7.1-r0)
(31/59) Installing g++ (6.3.0-r4)
(32/59) Installing make (4.2.1-r0)
(33/59) Installing fortify-headers (0.8-r0)
(34/59) Installing build-base (0.5-r0)
(35/59) Installing expat (2.2.0-r0)
(36/59) Installing pcre (8.40-r2)
(37/59) Installing git (2.13.0-r0)
(38/59) Installing xz-libs (5.2.3-r0)
(39/59) Installing lzo (2.10-r0)
(40/59) Installing squashfs-tools (4.3-r3)
(41/59) Installing libburn (1.4.6-r0)
(42/59) Installing ncurses-terminfo-base (6.0-r7)
(43/59) Installing ncurses-terminfo (6.0-r7)
(44/59) Installing ncurses-libs (6.0-r7)
(45/59) Installing libedit (20170329.3.1-r2)
(46/59) Installing libacl (2.2.52-r3)
(47/59) Installing libisofs (1.4.6-r0)
(48/59) Installing libisoburn (1.4.6-r0)
(49/59) Installing xorriso (1.4.6-r0)
(50/59) Installing acct (6.6.3-r0)
(51/59) Installing lddtree (1.26-r0)
(52/59) Installing libuuid (2.28.2-r2)
(53/59) Installing libblkid (2.28.2-r2)
(54/59) Installing device-mapper-libs (2.02.168-r3)
(55/59) Installing cryptsetup-libs (1.7.5-r0)
(56/59) Installing kmod (23-r1)
(57/59) Installing mkinitfs (3.1.0_rc1-r0)
Executing mkinitfs-3.1.0_rc1-r0.post-install
(58/59) Installing mtools (4.0.18-r1)
(59/59) Installing alpine-sdk (0.5-r0)
Executing busybox-1.26.2-r4.trigger
Executing ca-certificates-20161130-r2.trigger
OK: 194 MiB in 70 packages
 ---> 7d4954c95ad0
Removing intermediate container c0ede3153e40
Step 3/8 : ADD /src src
 ---> c37db4026404
Removing intermediate container 21b94cbce3f4
Step 4/8 : WORKDIR /src
 ---> 129be4a9733e
Removing intermediate container b6d03a905432
Step 5/8 : RUN mkdir out && gcc main.c -o out/helloworld
 ---> Running in fc192dbc6cdc
 ---> 851fe52c1924
Removing intermediate container fc192dbc6cdc
Step 6/8 : FROM alpine:latest
 ---> a41a7446062d
Step 7/8 : COPY --from=build /src/out/helloworld /bin/helloworld
 ---> 4e828d687fff
Removing intermediate container b61f3cf49406
Step 8/8 : ENTRYPOINT /bin/helloworld
 ---> Running in b4040a87c53c
 ---> caca5dbb3eda
Removing intermediate container b4040a87c53c
Successfully built caca5dbb3eda
Successfully tagged helloworld:multistage

```

## Image size

Image size is different only in binary size, tools are not present in final
image. Note intermediate container size

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
helloworld          multistage          caca5dbb3eda        53 seconds ago      3.98MB
<none>              <none>              851fe52c1924        54 seconds ago      182MB
alpine              latest              a41a7446062d        2 weeks ago         3.97MB

```

## Test container

```
$ docker run --rm helloworld:multistage
Hello world!!
Current time is Fri Jun  9 03:17:51 2017

```
