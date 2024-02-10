abstract class SavedInfoService {
  Future<bool> removeInfo(String key);

  Future<bool> saveInfo(String key, Object data);

  Future<Object?> getInfo(String key);

  Future<void> clear();

  Future<bool> has(String key);
}
