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
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import { Roles } from 'src/common/decorators/roles.decorator';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { AbstractScheduledNotificationService } from './abstract/scheduled-notification.abstract.service';
import { CreateScheduledNotificationInput } from './dto/create-scheduled-notification.input';
import { DeleteScheduledNotificationsInput } from './dto/delete-scheduled-notifications.input';
import { ListNotificationsInput } from './dto/list-notifications-input';
import { GetNotificationByIdParams } from './dto/notification-by-id.params';
import { UpdateScheduledNotificationInput } from './dto/update-scheduled-notification.input';
import { NotificationIntervalResponse } from './response/notification-interval.response';
import { NotificationTypeResponse } from './response/notification-type.response';
import { ScheduledNotificationPaginatedResponse } from './response/scheduled-notification-paginated.response';
import { ScheduledNotificationResponse } from './response/scheduled-notification-reponse';
import { ScheduledNotification } from './schemas/scheduled-notification.schema';

@Controller('scheduled-notifications')
@ApiTags('Scheduled Notification')
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class ScheduledNotificationController {
  constructor(
    private readonly scheduledNotificationService: AbstractScheduledNotificationService,
  ) {}

  @Get('')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: ScheduledNotificationPaginatedResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  listScheduledNotifications(
    @Query() paginationParams: PaginationParams,
    @Query() listNotificationsInput: ListNotificationsInput,
  ): Promise<PaginationModel<ScheduledNotification>> {
    return this.scheduledNotificationService.listNotifications(
      listNotificationsInput,
      paginationParams,
    );
  }

  @Get('types')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [NotificationTypeResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  getNotificationTypes(): NotificationTypeResponse[] {
    return this.scheduledNotificationService.getNotificationTypes();
  }

  @Get('intervals')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [NotificationIntervalResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  getNotificationIntervals(): NotificationIntervalResponse[] {
    return this.scheduledNotificationService.getNotificationIntervals();
  }

  @Post('')
  @ApiOkResponse({
    status: 201,
    description: 'OK response',
    type: ScheduledNotificationResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  createScheduledNotification(@Body() input: CreateScheduledNotificationInput) {
    return this.scheduledNotificationService.createScheduledNotification(input);
  }

  @Delete('')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.Admin, Role.Superadmin)
  deleteScheduledNotification(
    @Body() { notificationIds }: DeleteScheduledNotificationsInput,
  ): Promise<void> {
    return this.scheduledNotificationService.deleteScheduledNotifications(
      notificationIds,
    );
  }

  @Patch(':notificationId')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: ScheduledNotificationResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  updateScheduledNotification(
    @Param() { notificationId }: GetNotificationByIdParams,
    @Body() updateNotificationInput: UpdateScheduledNotificationInput,
  ): Promise<ScheduledNotification> {
    return this.scheduledNotificationService.updateScheduledNotification(
      notificationId,
      updateNotificationInput,
    );
  }

  @Get(':notificationId')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: ScheduledNotificationResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  findOne(
    @Param() { notificationId }: GetNotificationByIdParams,
  ): Promise<ScheduledNotification> {
    return this.scheduledNotificationService.findScheduledNotification(
      notificationId,
    );
  }
}
