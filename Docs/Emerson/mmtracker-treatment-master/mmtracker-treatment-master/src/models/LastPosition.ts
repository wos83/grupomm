import {
  Column,
  Entity,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

import Positions from './Position';

@Entity({ name: 'last_positions' })
class LastPosition {
  @PrimaryGeneratedColumn()
  id: number;

  @OneToOne(() => Positions)
  @JoinColumn()
  positions: Positions;

  @Column()
  deviceId?: string;

  @Column()
  fwVersion?: string;

  @Column()
  datetime?: Date;

  @Column()
  systemDate?: Date;

  @Column()
  latitude?: string;

  @Column()
  longitude?: string;

  @Column()
  speed?: number;

  @Column()
  course?: number;

  @Column()
  satellite?: number;

  @Column()
  odometer?: string;

  @Column()
  mainBattery?: string;

  @Column()
  backupBattery?: string;

  @Column()
  ignition?: string;

  @Column()
  inputOne?: boolean;

  @Column()
  inputTwo?: boolean;

  @Column()
  inputThree?: boolean;

  @Column()
  outputOne?: boolean;

  @Column()
  outputTwo?: boolean;

  @Column()
  backupBatteryPercent?: boolean;

  @Column()
  gpsFix?: boolean;
}

export default LastPosition;
