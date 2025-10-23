import { IsNotEmpty, IsString, MinLength } from 'class-validator';
import { IsAngolaPhone } from '../../../common/decorators/is-angola-phone.decorator';
import { ApiProperty } from '@nestjs/swagger';

export class LoginDto {
  @ApiProperty({
    description: 'Número de telefone angolano (formato: +244xxxxxxxxx)',
    example: '+244923456789',
  })
  @IsNotEmpty()
  phone: string;

  @ApiProperty({
    description: 'Senha do usuário (mínimo 6 caracteres)',
    example: '123456',
    minLength: 6,
  })
  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  password: string;
}
