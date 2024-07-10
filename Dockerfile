# 第一阶段：构建阶段
FROM golang:1.18-alpine AS builder
WORKDIR /app

# 将源代码复制到容器内
COPY . .

# 构建应用
RUN go env -w GO111MODULE=auto
RUN go build -o app .

# 第二阶段：生产运行阶段
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 从构建阶段复制编译好的二进制文件到新的镜像中
COPY --from=builder /app/app .

# 暴露应用使用的端口
EXPOSE 8080

# 定义容器启动时运行的命令
CMD ["./app"]
