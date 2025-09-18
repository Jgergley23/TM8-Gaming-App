import { Transform, Type } from 'class-transformer';
import {
  IsBoolean,
  IsEnum,
  IsNumber,
  IsString,
  ValidateNested,
} from 'class-validator';

import { Environment } from '../constants/environment.enum';

export class NodeConfig {
  @IsEnum(Environment, {
    message: `NODE_ENV must be one of the following values: ${Object.values(
      Environment,
    )}`,
  })
  public readonly ENV!: Environment;
}

export class ProjectConfig {
  @IsString({ message: 'PROJECT_NAME must be a string' })
  public readonly NAME!: string;

  @IsString({ message: 'PROJECT_DESCRIPTION must be a string' })
  public readonly DESCRIPTION!: string;

  @IsString({ message: 'PROJECT_VERSION must be a string' })
  public readonly VERSION!: string;
}

export class SwaggerConfig {
  @IsString({ message: 'SWAGGER_USERNAME must be a string' })
  public readonly USERNAME!: string;

  @IsString({ message: 'SWAGGER_PASSWORD must be a string' })
  public readonly PASSWORD!: string;
}

export class AppConfig {
  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'PORT must be a number' },
  )
  public readonly PORT!: number;

  @Type(() => NodeConfig)
  @ValidateNested()
  public readonly NODE!: NodeConfig;

  @Transform(({ value }) => Boolean(value))
  @IsBoolean()
  public readonly CLUSTERING!: boolean;
}

export class MongoRetryConfig {
  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'MONGO_RETRY_ATTEMPTS must be a number' },
  )
  public readonly ATTEMPTS!: number;

  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'MONGO_RETRY_DELAY must be a number' },
  )
  public readonly DELAY!: number;
}

export class MongoConfig {
  @IsString({ message: 'MONGO_URI must be a string' })
  public readonly URI!: string;

  @Type(() => MongoRetryConfig)
  @ValidateNested()
  public readonly RETRY!: MongoRetryConfig;
}

export class NotificationRedirectConfig {
  @IsString({ message: 'NOTIFICATION_REDIRECT_ONBOARDING must be a string' })
  public readonly ONBOARDING!: string;

  @IsString({ message: 'NOTIFICATION_REDIRECT_INACTIVE must be a string' })
  public readonly INACTIVE!: string;

  @IsString({ message: 'NOTIFICATION_REDIRECT_PREFERENCES must be a string' })
  public readonly PREFERENCES!: string;
}

export class NotificationConfig {
  @Type(() => NotificationRedirectConfig)
  @ValidateNested()
  public readonly REDIRECT!: NotificationRedirectConfig;
}

export class SendgridTemplateConfig {
  @IsString({
    message: 'SENDGRID_TEMPLATE_ADMINFORGOTPASSWORD must be a string',
  })
  public readonly ADMINFORGOTPASSWORD!: string;

  @IsString({
    message: 'SENDGRID_TEMPLATE_ADMINACCOUNTCREATED must be a string',
  })
  public readonly ADMINACCOUNTCREATED!: string;

  @IsString({
    message: 'SENDGRID_TEMPLATE_CONTACTFORM must be a string',
  })
  public readonly CONTACTFORM!: string;

  @IsString({
    message: 'SENDGRID_TEMPLATE_USERCHANGEEMAIL must be a string',
  })
  public readonly USERCHANGEEMAIL!: string;
}

export class SendgridConfig {
  @IsString({ message: 'SENDGRID_APIKEY must be a string' })
  APIKEY!: string;

  @IsString({ message: 'SENDGRID_FROM must be a string' })
  public readonly FROM!: string;

  @Type(() => SendgridTemplateConfig)
  @ValidateNested()
  public readonly TEMPLATE!: SendgridTemplateConfig;
}

export class FirebaseConfig {
  @IsString({ message: 'FIREBASE_PROJECTID must be a string' })
  public readonly PROJECTID!: string;

  @IsString({ message: 'FIREBASE_EMAIL must be a string' })
  public readonly EMAIL!: string;
}

export class S3Config {
  @IsString({ message: 'S3_ACCESSKEY must be a string' })
  ACCESSKEY!: string;

  @IsString({ message: 'S3_SECRET must be a string' })
  SECRET!: string;

  @IsString({ message: 'S3_BUCKET must be a string' })
  BUCKET!: string;

  @IsString({ message: 'S3_REGION must be a string' })
  REGION!: string;

  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'S3_MAXPHOTOSIZE must be a number' },
  )
  MAXPHOTOSIZE!: number;

  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'S3_MAXAUDIOSIZE must be a number' },
  )
  MAXAUDIOSIZE!: number;

  @IsString({ message: 'S3_AUDIOFORMAT must be a string' })
  AUDIOFORMAT!: string;
}

export class SuperadminConfig {
  @IsString({ message: 'SEEDER_SUPERADMIN_EMAIL must be a string' })
  public readonly EMAIL!: string;

  @IsString({ message: 'SEEDER_SUPERADMIN_NAME must be a string' })
  public readonly NAME!: string;

  @IsString({ message: 'SEEDER_SUPERADMIN_PASSWORD must be a string' })
  public readonly PASSWORD!: string;
}

export class UserConfig {
  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'SEEDER_USER_COUNT must be a number' },
  )
  COUNT!: number;
}
export class SeederConfig {
  @Type(() => SuperadminConfig)
  @ValidateNested()
  public readonly SUPERADMIN!: SuperadminConfig;

  @Type(() => UserConfig)
  @ValidateNested()
  public readonly USER!: UserConfig;
}

export class JwtRefreshConfig {
  @IsString({ message: 'JWT_EXPIRY must be a string' })
  public EXPIRY!: string;

  @IsString({ message: 'JWT_REFRESH must be a string' })
  public SECRET!: string;
}

export class JwtConfig {
  @IsString({ message: 'JWT_SECRET must be a string' })
  public SECRET!: string;

  @IsString({ message: 'JWT_EXPIRY must be a string' })
  public EXPIRY!: string;

  @Type(() => JwtRefreshConfig)
  @ValidateNested()
  public REFRESH!: JwtRefreshConfig;
}

export class GoogleConfig {
  @IsString({ message: 'GOOGLE_CLIENTID must be a string' })
  public CLIENTID!: string;

  @IsString({ message: 'GOOGLE_CLIENTSECRET must be a string' })
  public CLIENTSECRET!: string;
}

export class TwilioConfig {
  @IsString({ message: 'TWILIO_ACCOUNTSID must be a string' })
  public readonly ACCOUNTSID!: string;

  @IsString({ message: 'TWILIO_TOKEN must be a string' })
  public readonly TOKEN!: string;

  @IsString({ message: 'TWILIO_FROM must be a string' })
  public readonly FROM!: string;

  @Transform(({ value }) => Number(value))
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    { message: 'TWILIO_RETRIES must be a number' },
  )
  public readonly RETRIES!: number;
}

export class ThrottlerConfig {
  @IsString({ message: 'THROTTLER_TTL must be a number' })
  public readonly TTL!: number;

  @IsString({ message: 'THROTTLER_LIMIT must be a number' })
  public readonly LIMIT!: number;
}
export class EpicGamesEndpointConfig {
  @IsString({ message: 'EPIC_ENDPOINT_TOKENURL must be a string' })
  public readonly TOKENURL!: string;

  @IsString({ message: 'EPIC_ENDPOINT_ACCOUNTURL must be a string' })
  public readonly ACCOUNTURL!: string;
}

export class EpicGamesConfig {
  @IsString({ message: 'EPIC_CLIENTURL must be a string' })
  public readonly CLIENTURL!: string;

  @IsString({ message: 'EPIC_CLIENTURL must be a string' })
  public readonly CLIENTID!: string;

  @IsString({ message: 'EPIC_CLIENTURL must be a string' })
  public readonly CLIENTSECRET!: string;

  @Type(() => EpicGamesEndpointConfig)
  @ValidateNested()
  public ENDPOINT!: EpicGamesEndpointConfig;
}

export class AppleConfig {
  @IsString({ message: 'APPLE_CLIENTID must be a string' })
  public readonly CLIENTID!: string;
}

export class StreamChatConfig {
  @IsString({ message: 'STREAM_KEY must be a string' })
  public readonly KEY!: string;

  @IsString({ message: 'STREAM_SECRET must be a string' })
  public readonly SECRET!: string;

  @IsString({ message: 'STREAM_TOKENEXPHRS must be a number' })
  public readonly TOKENEXPHRS!: number;
}

export class RedisConfig {
  @IsString({ message: 'REDIS_URL must be a string' })
  public readonly URL!: string;
}

export class RootConfig {
  @Type(() => AppConfig)
  @ValidateNested()
  public readonly APP!: AppConfig;

  @Type(() => ProjectConfig)
  @ValidateNested()
  public readonly PROJECT!: ProjectConfig;

  @Type(() => SwaggerConfig)
  @ValidateNested()
  public readonly SWAGGER!: SwaggerConfig;

  @Type(() => MongoConfig)
  @ValidateNested()
  public readonly MONGO!: MongoConfig;

  @Type(() => SendgridConfig)
  @ValidateNested()
  public readonly SENDGRID!: SendgridConfig;

  @Type(() => FirebaseConfig)
  @ValidateNested()
  public readonly FIREBASE!: FirebaseConfig;

  @Type(() => S3Config)
  @ValidateNested()
  public readonly S3!: S3Config;

  @Type(() => SeederConfig)
  @ValidateNested()
  public readonly SEEDER!: SeederConfig;

  @Type(() => JwtConfig)
  @ValidateNested()
  public readonly JWT!: JwtConfig;

  @Type(() => GoogleConfig)
  @ValidateNested()
  public readonly GOOGLE!: GoogleConfig;

  @Type(() => TwilioConfig)
  @ValidateNested()
  public readonly TWILIO!: TwilioConfig;

  @Type(() => ThrottlerConfig)
  @ValidateNested()
  public readonly THROTTLER!: ThrottlerConfig;

  @Type(() => EpicGamesConfig)
  @ValidateNested()
  public readonly EPIC!: EpicGamesConfig;

  @Type(() => AppleConfig)
  @ValidateNested()
  public readonly APPLE!: AppleConfig;

  @Type(() => StreamChatConfig)
  @ValidateNested()
  public readonly STREAM!: StreamChatConfig;

  @Type(() => NotificationConfig)
  @ValidateNested()
  public readonly NOTIFICATION!: NotificationConfig;

  @Type(() => RedisConfig)
  @ValidateNested()
  public readonly REDIS!: RedisConfig;
}
