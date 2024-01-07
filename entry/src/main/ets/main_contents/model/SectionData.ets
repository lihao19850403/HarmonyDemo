import { ChapterData } from './ChapterData';

export class SectionData {

  /* 分段名称。 */
  name: string;

  /* 分段中的所有章节信息。 */
  chapters: ChapterData[];

  constructor(name: string, chapters: ChapterData[]) {
    this.name = name;
    this.chapters = chapters;
  }
}