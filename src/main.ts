import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { BadRequestException, ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      exceptionFactory(errors) {
        const messages = errors.map((error) => {
          return {
            [error.property]: Object.values(error.constraints),
          };
        });
        throw new BadRequestException(messages);
      },
    }),
  );
  // enpoint/api
  app.setGlobalPrefix('api');
  await app.listen(3000);
}
bootstrap();
