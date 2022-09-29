Description: Add kfreebsdgnu to GHC_CONVERT_OS in aclocal.m4
Author: Svante Signell <svante.signell@gmail.com>
Bug-Debian: https://bugs.debian.org/913140

Index: b/aclocal.m4
===================================================================
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -2048,7 +2048,7 @@ AC_DEFUN([GHC_CONVERT_OS],[
         $3="openbsd"
         ;;
       # As far as I'm aware, none of these have relevant variants
-      freebsd|netbsd|dragonfly|hpux|linuxaout|kfreebsdgnu|freebsd2|mingw32|darwin|nextstep2|nextstep3|sunos4|ultrix|haiku)
+      freebsd|netbsd|dragonfly|hpux|linuxaout|freebsd2|mingw32|darwin|nextstep2|nextstep3|sunos4|ultrix|haiku)
         $3="$1"
         ;;
       msys)
@@ -2068,6 +2068,9 @@ AC_DEFUN([GHC_CONVERT_OS],[
                 #      i686-gentoo-freebsd8.2
         $3="freebsd"
         ;;
+      kfreebsd*)
+        $3="kfreebsdgnu"
+        ;;
       nto-qnx*)
         $3="nto-qnx"
         ;;
