# Use the official OCaml OPAM image (Debian based, OCaml 4.14)
FROM ocaml/opam:debian-11-ocaml-4.14

# Set the working directory inside the container
WORKDIR /app

# Copy all your project files into the container
COPY --chown=opam:opam . .

# Build the OCaml project using Dune
RUN eval $(opam env) && dune build

# Run the simulation, then keep the container alive so Render doesn't crash it
CMD eval $(opam env) && dune exec ./main.exe && tail -f /dev/null
