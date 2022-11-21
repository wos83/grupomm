import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ name: 'packages' })
class Package {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  pack: string;

  @Column()
  datetime: Date;

  @Column()
  manufacturer: string;
}

export default Package;
