import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'send_commands' })
class SendCommands {
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
  commandName: string;
}

export default SendCommands;
