#!/QOpenSys/pkgs/bin/bash
# Führt CL-Befehle nacheinander in einem einzigen Job aus.
#
# Aufruf: runcl.sh <befehl> [<befehl> ...]
#
# Bricht beim ersten Fehler ab. Ein "!" vor dem Befehl übergeht dessen Fehler, wie in den
# Pseudoquellen von TOBi, z.B. "!DLTF FILE(LIB/X)".
cl -q "CHGJOB INQMSGRPY(*DFT)"
for cmd in "$@"; do
  if [[ $cmd == '!'* ]]; then
    cl -q "${cmd:1}"
  else
    cl "$cmd" || exit 1
  fi
done
