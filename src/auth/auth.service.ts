import { BadRequestException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserService } from 'src/user/user.service';
import { SignupDto } from './dto/signup.dto';
import { SigninDto } from './dto/signin.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}
    async signIn(signinDto: SigninDto) {
      const user = await this.userService.findOne(signinDto.email);

      if (!user) throw new BadRequestException('Invalid credentials');

      if (user?.password !== signinDto.password) {
        throw new BadRequestException('Invalid credentials');
      }

      const payload = { sub: user.id, email: user.email };

      return {
        access_token: await this.jwtService.signAsync(payload),
        user,
        success: true,
      };
    }

  async signUp(signupDto: SignupDto) {
    const userExists = await this.userService.findOne(signupDto.email);

    if (userExists) {
      throw new BadRequestException('User already exists');
    }

    const user = await this.userService.create(signupDto);

    const payload = { sub: user.id, email: user.email };

    return {
      access_token: await this.jwtService.signAsync(payload),
      user,
    };
  }
}
