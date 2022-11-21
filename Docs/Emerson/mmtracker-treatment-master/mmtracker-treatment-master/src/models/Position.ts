import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'positions' })
class Position {
  @PrimaryGeneratedColumn()
  id?: number;

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
  ignition?: boolean;

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
  backupBatteryPercent?: string;

  @Column()
  gpsFix?: boolean;
}

export default Position;
