import { checkReleaseVersion, searchReleaseLabel } from '../util';
import Base from './Base';

export default class Checker extends Base {
  constructor(tools: any) {
    super(tools);
  }

  public async run() {
    const { currVersion, nextVersion, tools } = this;
    if (!nextVersion) {
      tools.log('CheckReleaseProposal Failed, skip!');
      return;
    }

    if (checkReleaseVersion(currVersion, nextVersion)) {
      tools.log('CheckReleaseVersion Failed, skip!', nextVersion, currVersion);
      return;
    }

    const label = searchReleaseLabel(currVersion, nextVersion);

    if (!label) {
      tools.log('SearchReleaseLabel Failed, skip!', label);
      return;
    }

    tools.log('Label', label);
    if (label) {
      await this.updateLabel(label);
    }
  }
}