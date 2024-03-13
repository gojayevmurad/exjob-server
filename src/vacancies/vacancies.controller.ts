import { Controller, Get, Post } from '@nestjs/common';

@Controller('vacancies')
export class VacanciesController {
  @Get()
  findAll(): string {
    return 'This action returns all vacancies';
  }

  @Get('featured')
  findFeatured(): string {
    return 'This action returns all featured vacancies';
  }

  @Get('latest')
  findLatest(): string {
    return 'This action returns all latest vacancies';
  }

  @Get('details/:id')
  findOne(): string {
    return 'This action returns a vacancy by ID';
  }

  @Post('apply/:id')
  apply(): string {
    return 'This action applies to a vacancy';
  }
}
