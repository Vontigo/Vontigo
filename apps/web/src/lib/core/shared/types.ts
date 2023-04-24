
export type TableStructure = Array<
    {
        key: string,
        value: any,
        type: string,
        maxLength: string,
        nullable: boolean,
        defaultValue: any,
        reference: any
    }
>;
export type ReferenceStructure = Array<
    {
        id: number,
        seq: number,
        table: string,
        from: string,
        to: string,
        on_update: string,
        on_delete: string,
        match: string
    }
>;