import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'open_events' })
class OpenEvent {
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
  gpsFix?: boolean;

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
  evtId?: number;

  @Column()
  hourimeter?: string;

  @Column()
  isRealMessage?: boolean;

  @Column()
  type?: string;

  @Column()
  clientChecked?: Date;

  @Column()
  managerChecked?: Date;
}

export default OpenEvent;
