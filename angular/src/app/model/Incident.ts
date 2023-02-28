import {Level} from "./Level";
import {Type} from "./Type";

export interface Incident {
  id: number,
  titre: string,
  description: string,
  level: Level,
  type: Type,
  progress: number,
  email: string,
  dateCreation: string,
  dateModification: string,
  open: boolean,
}
