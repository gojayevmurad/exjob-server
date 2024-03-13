import {
  Controller,
  Delete,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { UserService } from './user.service';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Delete()
  deleteAll() {
    return this.userService.deleteAll();
  }

  @Post('change-photo')
  @UseInterceptors(
    FileInterceptor('file', {
      storage: diskStorage({
        destination: './uploads',
        filename: (req, file, callback) => {
          const name = file.originalname.split('.')[0];
          const exten = file.originalname.split('.')[1];
          const newFile =
            name.split(' ').join('-') + '-' + Date.now() + '.' + exten;

          callback(null, newFile);
        },
      }),
      fileFilter: (req, file, callback) => {
        if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)) {
          return callback(new Error('Only image files are allowed!'), false);
        }
        callback(null, true);
      },
    }),
  )
  uploadFile(@UploadedFile() file: Express.Multer.File) {
    const response = {
      path:
        'localhost:3000/' +
        file.path.replace(/\\/g, '/').replace('uploads/', ''),
    };

    return response;
  }
}
