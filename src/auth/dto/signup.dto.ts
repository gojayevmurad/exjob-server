import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsString,
  IsStrongPassword,
  MaxLength,
  MinLength,
} from 'class-validator';

// 0 = Not known; * 1 = Male; * 2 = Female; * 9 = Not applicable

enum Gender {
  NOT_KNOWN,
  MALE,
  FEMALE,
  NOT_APPLICABLE,
}

export class SignupDto {
  @IsString()
  @MinLength(3)
  @MaxLength(30)
  @IsNotEmpty()
  name: string;

  @IsString()
  @MinLength(3)
  @MaxLength(30)
  @IsNotEmpty()
  surname: string;

  @IsNumber()
  @IsNotEmpty()
  @IsEnum(Gender)
  gender: number;

  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsString()
  @IsStrongPassword({
    minLength: 8,
    minLowercase: 1,
    minUppercase: 1,
    minNumbers: 1,
    minSymbols: 1,
  })
  password: string;
}
