export type OperationType = 'Paiement' | "Transfert d'argent";

export interface Transaction {
  type: OperationType;
  target: string;
  amount: number;
  date: Date;
}
