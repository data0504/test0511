FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# 将您的项目文件复制到容器中
COPY . /app

# 运行构建命令
RUN dotnet restore
RUN dotnet publish -c Release -o out

# 定义最终的运行时镜像
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

# 指定应用程序入口点
ENTRYPOINT ["dotnet", "DX.dll"]
