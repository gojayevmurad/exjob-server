import { BadRequestException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

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

    const isMatch = await bcrypt.compare(signinDto.password, user.password);

    if (!isMatch) throw new BadRequestException('Invalid credentials');

    const payload = { sub: user.id, email: user.email };

    delete user.password;

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

    const saltOrRounds = 10;
    const hash = await bcrypt.hash(signupDto.password, saltOrRounds);

    signupDto.password = hash;

    const user = await this.userService.create(signupDto);

    const payload = { sub: user.id, email: user.email };

    return {
      access_token: await this.jwtService.signAsync(payload),
      user,
    };
  }
}
