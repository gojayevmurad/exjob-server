import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { PrismaModule } from './prisma/prisma.module';
import { VacanciesModule } from './vacancies/vacancies.module';

@Module({
  imports: [AuthModule, UserModule, PrismaModule, VacanciesModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
