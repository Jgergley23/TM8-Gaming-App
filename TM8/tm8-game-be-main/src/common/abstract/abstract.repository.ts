import { Injectable } from '@nestjs/common';
import {
  AnyKeys,
  AnyObject,
  Document,
  FilterQuery,
  HydratedDocument,
  Model,
  Query,
  QueryOptions,
  Types,
  UpdateQuery,
  UpdateWriteOpResult,
} from 'mongoose';

@Injectable()
export abstract class AbstractRepository<T> {
  protected constructor(protected readonly entity: Model<T>) {}

  /**
   * Creates an entity.
   */
  public async createOne(
    data: AnyObject | AnyKeys<Document<T>>,
  ): Promise<HydratedDocument<T>> {
    return await this.entity.create(data);
  }

  /**
   * Creates an entity.
   */
  public async createMany(
    data: AnyObject | AnyKeys<Document<T>>,
  ): Promise<HydratedDocument<T>[]> {
    const result = await this.entity.insertMany(data);
    return result as HydratedDocument<T>[];
  }

  /**
   * Gets many entities.
   */
  public async findMany(
    filter: FilterQuery<T> = {},
    projection: string | null = null,
    options?: QueryOptions,
  ): Promise<Document<T>[]> {
    return await this.entity.find(filter, projection, options);
  }

  /**
   * Gets many entities as plain objects.
   */
  public async findManyLean(
    filter: FilterQuery<T> = {},
    projection: string | null = null,
    options?: QueryOptions,
  ): Promise<T[]> {
    return await this.entity.find(filter, projection, options).lean();
  }

  /**
   * Gets one entity.
   */
  public async findOne(
    filter: FilterQuery<T> = {},
    projection?: string,
    options?: QueryOptions,
  ): Promise<(T & Document<T>) | null | undefined> {
    return await this.entity.findOne(filter, projection, options);
  }

  /**
   * Gets one entity as plain object.
   */
  public async findOneLean(
    filter: FilterQuery<T> = {},
    projection?: string,
    options?: QueryOptions,
  ): Promise<T> {
    return await this.entity.findOne(filter, projection, options).lean();
  }

  /**
   * Gets one entity as plain object.
   */
  public async findOneLeanPopulate(
    filter: FilterQuery<T> = {},
    populate: string,
    projection?: string,
    options?: QueryOptions,
  ): Promise<T> {
    return await this.entity
      .findOne(filter, projection, options)
      .populate(populate)
      .lean();
  }

  /**
   * Updates one entity by filter query.
   */
  public async updateOne(
    query: FilterQuery<T>,
    update: UpdateQuery<T>,
  ): Promise<T | null> {
    return await this.entity.findOneAndUpdate(query, update, { new: true });
  }

  /**
   * Updates one entity by ID.
   */
  public async updateOneById(
    id: string,
    update: UpdateQuery<T>,
  ): Promise<T | null> {
    return await this.entity.findOneAndUpdate(
      { _id: new Types.ObjectId(id) },
      update,
      { new: true },
    );
  }

  /**
   * Updates entities by filter.
   */
  public async updateMany(
    query: FilterQuery<T>,
    data: UpdateQuery<T>,
  ): Promise<Query<UpdateWriteOpResult, T & Document>> {
    return await this.entity.updateMany(query, data, { new: true });
  }

  /**
   * Deletes one entity by ID.
   */
  async deleteOne(query: FilterQuery<T>): Promise<T | void> {
    return await this.entity.findOneAndDelete(query).lean();
  }

  /**
   * Deletes multiple entities by IDs.
   */
  public async deleteMany(ids: string[]): Promise<number> {
    return (await this.entity.deleteMany({ _id: { $in: ids } })).deletedCount;
  }

  /**
   * Counts entities by filter.
   */
  async count(query?: FilterQuery<T>): Promise<number> {
    return await this.entity.countDocuments(query);
  }

  /**
   * Finds one entity or creates it if it doesn't exist.
   */
  async findOrCreate(
    data: AnyObject | AnyKeys<Document<T>>,
    filter: FilterQuery<T> = {},
    projection?: string,
    options?: QueryOptions,
  ): Promise<(T & Document<T>) | HydratedDocument<T>> {
    const entity = await this.findOne(filter, projection, options);

    if (!entity) {
      return await this.createOne(data);
    }

    return entity;
  }
}
