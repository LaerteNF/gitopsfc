# 'build' é o alias usado para referenciar a imagem que criamos
FROM golang:1.19 as build
WORKDIR /app
COPY . .
# 'CGO_ENABLED=0' é para desabilitar pacotes que C do go, outras configs do como como qual sistema operacional, qual arquitetura em que está rodando
# rodando, e build da aplicação conforme os fontes que foram copiados para a imagem
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

# from scratch é uma imagem vazia, copia a imagem gerada  acima (/app/server) para a imagem vazia (/app)
FROM scratch
WORKDIR /app
COPY --from=build /app/server .
ENTRYPOINT ["./server"]