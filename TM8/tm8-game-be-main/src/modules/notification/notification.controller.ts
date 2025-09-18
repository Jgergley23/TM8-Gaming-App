import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  Patch,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { ApiOkResponse, ApiResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import {
  CurrentUser,
  IUserTokenData,
} from 'src/common/decorators/current-user.decorator';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import { TGMDConflictException } from 'src/common/exceptions/custom.exception';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { AbstractNotificationService } from './abstract/notification.abstract.service';
import { CreateCallNotificationDto } from './dto/create-call-notification.dto';
import { CreateMessageNotificationDto } from './dto/create-message-notification.dto';
import { GetNotificationByIdParams } from './dto/get-notification-by-id.params';
import { NotificationRefreshTokenDto } from './dto/notification-refresh-token.dto';
import { UpdateNotificationSettingsDto } from './dto/update-notification-settings.dto';
import { NotificationPaginatedResponse } from './response/notification-paginated.response';
import { NotificationSettingsOptionResponse } from './response/notification-settings-option.response';
import { NotificationResponse } from './response/notification.response';
import { UnreadNotificationsResponse } from './response/unread-notifications.response';
import { Notification } from './schemas/notification.schema';

@Controller('notifications')
@ApiTags('Notification')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class NotificationController {
  constructor(
    private readonly notificationService: AbstractNotificationService,
  ) {}

  @Post('token/refresh')
  @ApiResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  refreshNotificationToken(
    @CurrentUser() user: IUserTokenData,
    @Body() { token }: NotificationRefreshTokenDto,
  ): Promise<void> {
    return this.notificationService.refreshToken(user.sub, token);
  }

  @Post('message')
  @ApiResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  createMessageNotification(
    @CurrentUser() user: IUserTokenData,
    @Body() createMessageNotificationDto: CreateMessageNotificationDto,
  ): Promise<void> {
    if (user.sub === createMessageNotificationDto.recipientId)
      throw new TGMDConflictException(
        'Cannot send a notification to yourself.',
      );

    return this.notificationService.createMessageNotification(
      createMessageNotificationDto,
    );
  }

  @Post('call')
  @ApiResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  createCallNotification(
    @CurrentUser() user: IUserTokenData,
    @Body() createCallNotificationDto: CreateCallNotificationDto,
  ): Promise<void> {
    if (user.sub === createCallNotificationDto.recipientId)
      throw new TGMDConflictException(
        'Cannot send a notification to yourself.',
      );
    return this.notificationService.createCallNotification(
      createCallNotificationDto,
    );
  }

  @Get('unread/count')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UnreadNotificationsResponse,
  })
  @Roles(Role.User)
  checkUnreadNotifications(
    @CurrentUser() user: IUserTokenData,
  ): Promise<UnreadNotificationsResponse> {
    return this.notificationService.checkUnreadNotifications(user.sub);
  }

  @Get('')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: NotificationPaginatedResponse,
  })
  @Roles(Role.User)
  listUsers(
    @CurrentUser() user: IUserTokenData,
    @Query() paginationParams: PaginationParams,
  ): Promise<PaginationModel<Notification>> {
    return this.notificationService.listUserNotifications(
      user.sub,
      paginationParams,
    );
  }

  @Patch('settings')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  updateNotificationSettings(
    @CurrentUser() user: IUserTokenData,
    @Body() updateSettingsDto: UpdateNotificationSettingsDto,
  ): Promise<void> {
    return this.notificationService.updateNotificationSettings(
      user.sub,
      updateSettingsDto,
    );
  }

  @Get('settings/options')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [NotificationSettingsOptionResponse],
  })
  @Roles(Role.User)
  getNotificationSettingsOptions(): NotificationSettingsOptionResponse[] {
    return this.notificationService.getNotificationSettingsOptions();
  }

  @Delete(':notificationId')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  deleteNotification(
    @CurrentUser() user: IUserTokenData,
    @Param() { notificationId }: GetNotificationByIdParams,
  ): Promise<void> {
    return this.notificationService.deleteNotification(
      user.sub,
      notificationId,
    );
  }

  @Get(':notificationId')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: NotificationResponse,
  })
  @Roles(Role.User)
  getNotificationDetail(
    @CurrentUser() user: IUserTokenData,
    @Param() { notificationId }: GetNotificationByIdParams,
  ): Promise<Notification> {
    return this.notificationService.getNotificationDetail(
      user.sub,
      notificationId,
    );
  }

  @Patch(':notificationId/read')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  markNotificationAsRead(
    @CurrentUser() user: IUserTokenData,
    @Param() { notificationId }: GetNotificationByIdParams,
  ): Promise<void> {
    return this.notificationService.markNotificationAsRead(
      user.sub,
      notificationId,
    );
  }
}
