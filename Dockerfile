FROM ocaml/opam:debian-ocaml-5.2

WORKDIR /app

COPY . .

RUN ocamlc \
    foundational.mli \
    descriptive.mli \
    authority.mli \
    evidentiary.mli \
    architecture.mli \
    runtime_simulation.ml
    -o main

CMD ["./main"]
