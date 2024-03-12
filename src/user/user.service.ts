import { Injectable } from '@nestjs/common';
import { SignupDto } from 'src/auth/dto/signup.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserService {
  constructor(private readonly prismaService: PrismaService) {}

  async findById(id: string) {
    return this.prismaService.user.findUnique({
      where: {
        id,
      },
    });
  }

  async findOne(email: string) {
    return this.prismaService.user.findUnique({
      where: {
        email,
      },
    });
  }

  async create(signupDto: SignupDto) {
    return this.prismaService.user.create({
      data: signupDto,
    });
  }
}
