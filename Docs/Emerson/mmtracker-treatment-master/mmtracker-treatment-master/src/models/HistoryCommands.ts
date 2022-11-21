import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'history_commands' })
class HistoryCommands {
  @PrimaryGeneratedColumn()
  id?: number;

  @Column()
  data: string;

  @Column()
  deviceId: string;

  @Column()
  manufacturer: string;

  @Column()
  sentDate: Date;

  @Column()
  requestDate: Date;

  @Column()
  confirmDate: Date;

  @Column()
  commandName: string;
}

export default HistoryCommands;
