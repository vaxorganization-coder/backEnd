# 🚀 Scripts de Deploy - Vax Vaquinha Backend

Este diretório contém scripts para facilitar o deploy e gerenciamento da aplicação na VPS.

## 📋 Scripts Disponíveis

### 1. `deploy.sh` - Deploy Completo
Script principal para fazer deploy completo da aplicação.

```bash
./deploy.sh
```

**O que este script faz:**
- ✅ Puxa as últimas mudanças do repositório (`git pull`)
- ✅ Instala dependências (`npm install`)
- ✅ Gera o cliente Prisma (`npx prisma generate`)
- ✅ Executa migrações do banco (`npx prisma migrate deploy`)
- ✅ Compila a aplicação (`npm run build`)
- ✅ Para o processo PM2 existente (se houver)
- ✅ Inicia a aplicação com PM2
- ✅ Salva a configuração do PM2
- ✅ Configura o PM2 para iniciar automaticamente

### 2. `restart.sh` - Restart Rápido
Script para reiniciar rapidamente a aplicação sem rebuild.

```bash
./restart.sh
```

**Uso:** Quando você só quer reiniciar a aplicação sem fazer deploy completo.

### 3. `monitor.sh` - Monitoramento
Script para monitorar e gerenciar a aplicação.

```bash
# Ver status da aplicação
./monitor.sh status

# Ver logs em tempo real
./monitor.sh logs

# Reiniciar aplicação
./monitor.sh restart

# Parar aplicação
./monitor.sh stop

# Iniciar aplicação
./monitor.sh start
```

## 🔧 Comandos PM2 Úteis

```bash
# Ver status de todos os processos
pm2 status

# Ver logs da aplicação
pm2 logs vax-backend

# Ver logs em tempo real
pm2 logs vax-backend --follow

# Reiniciar aplicação
pm2 restart vax-backend

# Parar aplicação
pm2 stop vax-backend

# Iniciar aplicação
pm2 start vax-backend

# Deletar processo do PM2
pm2 delete vax-backend

# Salvar configuração atual
pm2 save

# Configurar PM2 para iniciar no boot
pm2 startup
```

## 🚨 Troubleshooting

### Se a aplicação não iniciar:
1. Verifique os logs: `pm2 logs vax-backend`
2. Verifique se todas as dependências estão instaladas: `npm install`
3. Verifique se o banco de dados está acessível
4. Verifique as variáveis de ambiente no arquivo `.env`

### Se houver erro de dependências:
```bash
# Limpar cache do npm
npm cache clean --force

# Deletar node_modules e reinstalar
rm -rf node_modules package-lock.json
npm install
```

### Se houver erro de migração do banco:
```bash
# Verificar status das migrações
npx prisma migrate status

# Aplicar migrações pendentes
npx prisma migrate deploy
```

## 📝 Notas Importantes

- **Sempre execute os scripts do diretório raiz do projeto**
- **Certifique-se de que o arquivo `.env` está configurado corretamente**
- **O PM2 salvará automaticamente a configuração após o deploy**
- **Use `./monitor.sh logs` para acompanhar os logs em tempo real**

## 🔄 Fluxo de Deploy Recomendado

1. **Desenvolvimento local** → commit e push
2. **Na VPS**: `./deploy.sh` (deploy completo)
3. **Verificar**: `./monitor.sh status`
4. **Se necessário**: `./monitor.sh logs` para debug
