import { Module } from '@nestjs/common';
import { ContributionService } from './contribution.service';
import { ContributionController } from './contribution.controller';
import { AuthModule } from '../auth/auth.module';
import { PrismaModule } from '../../prisma/prisma.module';
import { CampaignModule } from '../campaign/campaign.module';
import { UsersModule } from '../users/users.module';

@Module({
  imports: [AuthModule, PrismaModule, CampaignModule, UsersModule],
  controllers: [ContributionController],
  providers: [ContributionService],
})
export class ContributionModule {}
